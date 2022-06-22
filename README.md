# Exponentially Weighted Moving Averages

A mathematical utensil to track an average number of something over a period of time.
Using math wizardry you do not have to keep track of all samples;
you simply feed data in at a fixed rate and it will be integrated in to a rolling average over some period of time.

An exponentially weighted standard deviation component is also provided.
This tracks both the rolling average over time in a fixed amount of memory but also the variance of the data coming in.

These are not mathematically identical to correct traditional averages and deviation scores.
However,
they are useful enough for many process control and monitoring tasks.

One example of use is for making accurate progress trackers:
keep a rolling average of the past 30 seconds to account for fluctuations in transfer or processing speed,
then look at the remaining data to process and divide by the average.
This is gives a reasonably accurate estimate because changes in processing speed are accounted for gently.

A creative use is by using custom tunings of the Alpha value you can also mimmick certain kinds of physical hysterisis (such as immitating the delays on analogue circuits.)

# Usage

```nim
import icedewma

var e = Ewma()
e.set_n_days(30) # create rolling average for 30 days
e.value = 100 #

while true:
   let v = measure()
   e.integrate(v)
   echo "Average thingdoer over 30 days: ", e.value
   # .. wait one day ..
```

# Numerical Accuracy

I have not run tests to see how accurate mean and stdev are with these compared to their formally correct alternatives.

# License

- MPL-2.

