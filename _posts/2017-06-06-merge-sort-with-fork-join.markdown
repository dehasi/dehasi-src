---
layout: post
title:  "Mergesort with Fork Join Pool"
---

The simplest task which shows how the fork-join framework works is Mergesort. Mergesort is a simple and well-known algorithm for arrays sorting. 
The main idea is split array for small chunks, sort them and then merge already sorted chunks in the one array.  
Fork join pool allows split each task to subtasks and execute it in parallel and then use the result.

In applying merge sort to the fork-join pool we have to decide which part is a fork part and which part is a joining part. 
It is very obvious that the merge part in the merge sort is a joining part. And splitting array to chunks is a fork part.

Let's write some code. Let's write the merge function first:

{% highlight java %}
public static List<Long> merge(List<Long> a, List<Long> b) {
    int i=0, j=0;
    List<Long> result = new ArrayList<>(a.size() + b.size());
    while(i < a.size() && j < b.size())
        result.add(a.get(i) < b.get(j) ? a.get(i++): b.get(j++));

    while(i < a.size())
        result.add(a.get(i++));

    while(j < b.size())
        result.add(b.get(j++));

    return result;
}

public static long[] merge(long[] a, long[] b) {

    long[] answer = new long[a.length + b.length];
    int i = 0, j = 0, k = 0;

    while(i < a.length && j < b.length)
        answer[k++] = a[i] < b[j] ? a[i++] : b[j++];

    while(i < a.length)
        answer[k++] = a[i++];

    while(j < b.length)
        answer[k++] = b[j++];

    return answer;
}
{% endhighlight %}

Now, when we able to merge a result let's write a task for the fork-join pool. 
There are few types of task for the fork-join pool. All of then are inherited from ForkJoinTask. 
RecursiveTask is very suitable for our problem, so I take it. I have to override only one method - 
"compute" where I have to decide how I'm going to split tasks and how I'm going to handle the result. 

First of all, I want to sort an array manually if it small. That's why I set up a threshold. 
If the input array is equal or less than the threshold I sort it by Stream API. Otherwise, I'll split it to two arrays, 
execute the same task recursively and then just merge the result.

{% highlight java %}
public static class MergeTask extends RecursiveTask<List<Long>> {
    private static final int THRESHOLD = 4;
    private final List<Long> list;

    public MergeTask(List<Long> list) {
        this.list = list;
    }

    @Override    
    protected List<Long> compute() {
        if (list.size() < THRESHOLD) {
            return list.stream().sorted().collect(toList());
        }

        MergeTask left = new MergeTask(list.stream().limit(list.size()/2).collect(toList()));
        MergeTask right = new MergeTask(list.stream().skip(list.size()/2).collect(toList()));
        invokeAll(left, right);

        return merge(left.join(), right.join());
    }
}
{% endhighlight %}

The most part of work is already done. Let's just write some test and run it. 
I also wrote a function which generates an array and the function which tests is an array sorted. 

{% highlight java %}
public class FJMergeSort {

    public static void main(String[] args) {
        Long[] ar = privideArray(100);
        List<Long> longs = asList(ar);
        Arrays.stream(ar).forEach(x -> System.out.print(x + " "));
        System.out.println(isSorted(longs));

        ForkJoinPool pool = new ForkJoinPool();
        ForkJoinTask<List<Long>> task = new MergeTask(longs);
        List<Long> result = pool.invoke(task);
        pool.shutdown();

        result.stream().forEach(x -> System.out.print(x + " "));
        System.out.println(isSorted(result));
        asList(ar).stream().sorted().forEach(x -> System.out.print(x + " "));
    }

    public static class MergeTask extends RecursiveTask<List<Long>> {
        private static final int THRESHOLD = 4;
        private final List<Long> list;

        public MergeTask(List<Long> list) {
            this.list = list;
        }

        @Override        
        protected List<Long> compute() {
            if (list.size() < THRESHOLD) {
                return list.stream().sorted().collect(toList());
            }

            MergeTask left = new MergeTask(list.stream().limit(list.size()/2).collect(toList()));
            MergeTask right = new MergeTask(list.stream().skip(list.size()/2).collect(toList()));
            invokeAll(left, right);

            return merge(left.join(), right.join());
        }
    }

    public static List<Long> merge(List<Long> a, List<Long> b) {
        int i=0, j=0;
        List<Long> result = new ArrayList<>(a.size() + b.size());
        while(i < a.size() && j < b.size())
            result.add(a.get(i) < b.get(j) ? a.get(i++): b.get(j++));

        while(i < a.size())
            result.add(a.get(i++));

        while(j < b.size())
            result.add(b.get(j++));

        return result;
    }

    public static long[] merge(long[] a, long[] b) {

        long[] answer = new long[a.length + b.length];
        int i = 0, j = 0, k = 0;

        while(i < a.length && j < b.length)
            answer[k++] = a[i] < b[j] ? a[i++] : b[j++];

        while(i < a.length)
            answer[k++] = a[i++];

        while(j < b.length)
            answer[k++] = b[j++];

        return answer;
    }

    public static Long[] privideArray(int length) {
        assert length > 0;
        Random random = new Random(length);
        Long[] array = new Long[length];
        for (int i = 0; i < array.length; i++) {
            array[i] = Long.valueOf(random.nextInt(10));
        }
        return array;
    }

    static boolean isSorted(List<Long> array) {
        for(int i = 1; i < array.size(); i++) {
            if(array.get(i-1) > array.get(i)) return false;
        }
        return true;
    }
}
{% endhighlight %}
Merge sort is a good example how the fork-join pool works. But in real life, the best (and shortest) way to sort an array is using Stream API:

{% highlight java %}
List<Long> list = asList(4L, 3L, 1L).stream().parallel().sorted().collect(toList());
{% endhighlight %}

This post is my attempt to learn jekyll and github pages. The oroginal of my post was published [here][ms-goog].                  

[ms-goog]: https://rgaleyev.blogspot.com/2017/06/mergesort-with-fork-join-poll.html
