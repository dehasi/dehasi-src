---
layout: post
title:  "Unit testing"
published: false
---

### Split test into logical blocks 
There are three parts of test Prepare Act and Check;

It’s ok to add comments:
`//given //when //then // and`
but sometimes a blank line separator is enough.

### One test checks one thing
When something fails it’s good to know what exactly. which part of logic. 
But "one test - one assert" sounds fanatical.

### Give informative names
A test name has to contain information about the test. There are few popular approaches. But I suggest

{% highlight java %}
@Test
methodName_condition_result()
methodName_result()
{% endhighlight %}

Don’t use 'should' word in test names. "shouldReturn..." can be simply replaced by "returns...", "shouldThrow.." -> "throws...".

The annotation `@Before` can be used few times that’s why it's worth to give it some understandable name.

{% highlight java %}
@Before //can be few methods
createMocks(); // don’t just setUp
{% endhighlight %}

### Think if you need to test a private method
If you have a private method which needs to be tested, think twice. 
Probably you have not good architecture. But if you want to test it anyway use  
`@VisibleForTesting` annotation which says that this method should be private but it has the package-private access only for testing purpose. 

### MVC tests
Use mockmvc to test a controller layer. 
Consider also Spring Cloud Contract and Spring Rest Docs to keep API contract and Documentation up to date.


Use mocks

### Use real(-ish) data
It’s good to reflect business logic to test data. Probably somebody else will maintain your tests. 
A good data gives move context.

i.e. 
{% highlight java %}
private static final String CARD_NUMBER = "a_card_number"; // wrong
private static final String CARD_NUMBER = "SN123456"; //good
{% endhighlight %}

### Coverage
Don’t write artificial tests to shut up Sonar. 
Test coverage should say which logic is not covered yet and should be covered. There should be any quality targets (some % of coverage).

### Links
[7 Popular Unit Test Naming Conventions](https://dzone.com/articles/7-popular-unit-test-naming)

[Google Testing Blog](https://testing.googleblog.com)

[Spring MVC Test Integration](https://docs.spring.io/spring-security/site/docs/current/reference/html/test-mockmvc.html)

[Martin Fowler: test coverage](https://martinfowler.com/bliki/TestCoverage.html)

