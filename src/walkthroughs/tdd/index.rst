:orphan:

.. _tdd-walkthrough:

================
Walkthrough: TDD
================


Setup
=====

* We will use the same repo from Day 1
* Open `the car unit tests project <https://gitlab.com/LaunchCodeTraining/car-unit-tests>`_ in VSCode
* Checkout the ``unit-testing-solution`` branch
* Create a new branch called ``tdd``

Follow Along
============

1. Discuss the requirements we want to add
2. Create a test list
3. Write the tests
4. Make them pass
5. Clean up the code if there are any code smells

Discuss Requirements
====================

Following TDD and the red-green-refactor workflow we need to understand our requirements before writing any code.

Today we will be implementing Range, and Trip Meter functionality.

The Range functionality will calculate how many more miles the car can drive before running out of gas. The output should be a Double representing the miles the car can drive before needing to fuel up.

The Trip Meter will be a separate resettable odometer. This will allow a user to track the number of miles travelled on a specific trip.

Create a Test List - Range Feature
==================================

Based on the requirements we need to create three tests

* testRangeOnInitialization - create a car and check range
* testRangeAfterDriving - drive a car and verify remaining range
* testRangeAfterAddingGas - verify the range after adding gas to the tank

Write the Tests - Range Feature
===============================

.. sourcecode:: java

    @Test
    public void testRangeOnInitialization() {
        Car testCar = new Car("a", "a", 10, 20);
        assertEquals(200, testCar.getRange());
    }

    @Test
    public void testRangeAfterDriving() {
        Car testCar = new Car("a", "a", 10, 20);
        testCar.drive(100);
        assertEquals(100, testCar.getRange());
    }

    @Test
    public void testRangeAfterAddingGas() {
        Car testCar = new Car("a", "a", 10, 20);
        testCar.drive(200);
        testCar.addGas(5.0);
        assertEquals(100, testCar.getRange());
    }

What happens when you run the tests?

Compilation Error! We are calling some methods that don't yet exist. We will need to create these methods to get our tests to run. Remember we want to see a failing red test before a successful green test.

Add Missing Methods
-------------------

We need to add ``getRange()`` to ``Car.java``.

.. sourcecode:: java

    public double getRange() {
        return this.gasTankLevel;
    }

After adding the code, run the tests again. Our tests should run now, and they should fail.

Make our Tests Pass
-------------------

Let's get our tests to pass:

.. sourcecode:: java

    public double getRange() {
        return this.gasTankLevel * this.milesPerGallon;
    }

Now we have introduced the proper logic that should return the correct range calculation. Let's re-run those tests.

This time they are passing! In this case we don't need to refactor. Our code is descriptive, efficient, and all of our tests are passing. Let's move on.

Create a Test List - Trip Meter Feature
=======================================

Based on the requirements we need to create three tests

* testInitialValue - create a car and verify initial trip value is 0
* testAfterDriving - drive a car and verify trip value is driven amount
* testResetAfterDriving - drive a car, reset trip, then verify trip is 0
* testResetThenDrive - drive, reset the trip, drive again, verify trip value is driven amount

Write the Tests - Trip Meter Feature
====================================

.. sourcecode:: java

    @Test
    public void testInitialValue() {
        Car testCar = new Car("a", "a", 10, 20);
        assertEquals(0, testCar.getTripMeter());
    }

    @Test
    public void testAfterDriving() {
        Car testCar = new Car("a", "a", 10, 20);
        testCar.drive(50);
        assertEquals(50, testCar.getTripMeter());
    }

    @Test
    public void testResetAfterDriving() {
        Car testCar = new Car("a", "a", 10, 20);
        testCar.drive(50);
        testCar.resetTripMeter();
        assertEquals(0, testCar.getTripMeter());
    }

    @Test
    public void testResetThenDrive() {
        Car testCar = new Car("a", "a", 10, 20);
        testCar.drive(50);
        testCar.resetTripMeter();
        testCar.drive(25)
        assertEquals(25, testCar.getTripMeter());
    }

What happens when you run the tests?

Compilation error!

Add Missing methods
-------------------

We will need to add some methods to our ``Car.java`` class:

.. sourcecode:: java

    public double getTripMeter() {
        return 0;
    }

    public void resetTripMeter() {
        
    }

These methods are lacking for now, but should get us past our compilation errors.


Make Our Tests Pass
===================

We need to add a property ``tripMeter`` and then update the methods we just added: ``getTripMeter()`` and ``resetTripMeter()`` to ``Car.java``.

.. sourecode:: java

    // properties
    private double tripMeter;

    // constructor
    public Car(String make, String model, int gasTankSize, double milesPerGallon) {
        this.make = make;
        this.model = model;
        this.gasTankSize = gasTankSize;
        // Gas tank level defaults to a full tank
        this.gasTankLevel = gasTankSize;
        this.milesPerGallon = milesPerGallon;
        this.odometer = 0;
        this.tripMeter = 0;
    }

    // previously added method updates
    public double getTripMeter() {
        return this.tripMeter;
    }

    public void resetTripMeter() {
        this.tripMeter = 0;
    }

Run the tests again. They should be passing now!

Do we need a refactor?
