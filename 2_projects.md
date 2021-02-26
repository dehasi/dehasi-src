---
layout: page
title: Projects
permalink: projects/
---

### Apache Ignite ML

Machine Leaning module in [Apache Ignite](https://ignite.apache.org/).

I implemented few Bayesian algorithms.

My humble [commits](https://github.com/apache/ignite/commits?author=dehasi)


### ZeLiba

[ZeLiba](https://github.com/dehasi/zeliba) is a DSL-ish library to make comparisons more readable.
Also, provides pattern-matching for Java 8 

#### Examples

{% highlight java %}
Comparable<T> val1 = ...
Comparable<T> val2 = ...

if (the(val1).isGreaterThan(val2)) {
    ...
}

if (the(val2).isLessThan(val1)) {
    ...
}
{% endhighlight %}

{% highlight java %}
public static void main(String[] args) {
    String language = (args.length == 0) ? "EN" : args[0];

    System.out.println(when(language)
        .is("EN").then("Hello!")
        .is("FE").then("Salut!")
        .is("ES").then("Hola!")
        .orElse(format("Sorry, I can't greet you in %s yet", language))
    );
}
{% endhighlight %}

see more [Examples](https://github.com/dehasi/zeliba#Examples)

### Практический минимум (Practical minimum)

A semester course in Saint-Petersburg [Computer Science Center](https://compscicenter.ru/).


The [course page](https://compscicenter.ru/courses/practical-minimum/).



