---
layout: post
title:  "Comparator tricks"
published: false
---

Let's create a set of strings. There is nothing new. Set of strings is used very widely in code. Nothing special.

{% highlight java %}    Set<String> s = new TreeSet<>(); {% endhighlight %}

But let's keep case insensitive strings in our set. It is very easy because we use a tree set. 
It needs to put a comparator as a constructor parameter.

{% highlight java %}
private static final Comparator<String> COMPARATOR = (o1, o2) -> o1.compareToIgnoreCase(o2);
Set<String> s = new TreeSet<>(COMPARATOR);
{% endhighlight %}

Let's put some values to the set.

{% highlight java %}
s.addAll(asList("a", "b"));
{% endhighlight %}

And now we consider how the removeAll function works.
I'm not going to copy-paste Javadoc. So let's write some tests and run it.

{% highlight java %}
static void test(String... args) {
    Set<String> s = new TreeSet<>(COMPARATOR);
    s.addAll(asList("a", "b"));
    List<String> c = asList(args);
    s.removeAll(c);
    System.out.println(s);
}
public static void main(String[] args) {
    test("A");
    test("B");
}
// - result
[b]
[a]
{% endhighlight %}

Everything looks good. Let's remove all values from the set,
{% highlight java %}
test("A", "B");
//-result
[a, b]
{% endhighlight %}

What? Why removeAll can remove each element separately but can't remove the whole collection?
The answer in the source code. Let's check what actually going on when somebody calls the removeAll function. As we can see, the removeAll function iterates over collection and call remove method if the collection size is lower than the set size. Very logic.
This is JDK code for AbstractSet:

{% highlight java %}
public boolean removeAll(Collection<?> c) {
    Objects.requireNonNull(c);
    boolean modified = false;

    if (size() > c.size()) {
        for (Iterator<?> i = c.iterator(); i.hasNext(); )
            modified |= remove(i.next());
    } else {
        for (Iterator<?> i = iterator(); i.hasNext(); ) {
            if (c.contains(i.next())) {
                i.remove();
                modified = true;
            }
        }
    }
    return modified;
}
{% endhighlight %}
But if the collection size equals or greater that the set size, then removeAll method iterates over
the set and checks if the collection contains an element from the set. The problem like our appears 
if the set and the collection have different comparators. As we can see. The set has "A" element. But the collection doesn't.
{% highlight java %}
static void testAB() {
    
    Set<String> s = new TreeSet<>(COMPARATOR);
    s.addAll(asList("a", "b"));
    List<String> c = asList("A", "B");

    System.out.println("A in the set:" + s.contains("A"));
    System.out.println("a in the set:" + s.contains("a"));
    System.out.println("A in the col:" + c.contains("A"));
    System.out.println("a in the col:" + c.contains("a"));

    s.removeAll(c);
    System.out.println(s);
}
//- result
A in the set:true
a in the set:true
A in the col:true
a in the col:false
[a, b]
{% endhighlight %}
As this part of the code is used from all ancestors of the Abstract set. This behavior theoretically can appear everywhere. Be careful.

This post is my attempt to learn jekyll and github pages. The oroginal of my post was published [here][cs-goog].                  

[cs-goog]: https://rgaleyev.blogspot.com/2017/05/lets-create-set-of-strings.html

