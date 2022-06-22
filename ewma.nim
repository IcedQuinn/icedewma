# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

type
   EwmaBase*[T] = object
      value*, alpha*: T

   Ewma* = EwmaBase[float]
   EwmaF* = EwmaBase[float32]
   EwmaD* = EwmaBase[float64]

   EwsdBase*[T] = object
      mu*: EwmaBase[T]
      value*: T

   Ewsd* = EwsdBase[float]
   EwsdF* = EwsdBase[float32]
   EwsdD* = EwsdBase[float64]

func update*[T](self: var EwmaBase[T]; integral: T) =
   ## Integrates a new value with the moving average.
   self.value =
      (integral.T * self.alpha) +
      ((1.T - self.alpha) * self.value)

func update*[T](self: var EwsdBase[T]; integral: T) =
   ## Integrates a new value with the moving average and deviation.
   let k = (integral - self.mu.value)
   let k2 = k * k
   self.value =
      (1 - self.mu.alpha) *
      (self.value + (self.mu.alpha * k2))
   self.mu.update(integral)

func set_n_days*[T](self: var EwmaBase[T]; days: int) =
   ## Configures the EWMA to average results over `days` number of days while receiving one sample per day.
   self.alpha = 2.T / (days.T + 1)

func set_n_days*[T](self: var EwsdBase[T]; days: int) =
   self.mu.set_n_days(days)

