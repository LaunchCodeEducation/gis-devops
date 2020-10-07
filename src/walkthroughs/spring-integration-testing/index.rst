:orphan:

.. _SIT-walkthrough:

=====================================
Walkthrough: Spring Integration Tests
=====================================

Concept
=======

With integration testing our objective is to ensure the technologies work together correctly. In this case that our application can handle HTTP requests, serve HTTP responses and communicate with the database properly.

Setup
=====

We have some setup we need to perform before we can write and run our integration tests.

We will:

- update our ``application.properties`` file to use environment variables to externalize our configuration
- use the included ``docker-compose.yml`` to create a testing database
- Add ``IntergrationTestConfig.java`` file
- Finally create the ``CarsControllerTests.java`` file

Using Environment Variables in application.properties
-----------------------------------------------------

Throughout this class we have been hard coding our development environment properties into our ``application.properties`` file. We should be using environment variables to externalize our database configuration.

.. sourcecode:: text

    spring.datasource.driver-class-name=org.postgresql.Driver
    spring.datasource.url=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}
    spring.datasource.username=${DB_USER}
    spring.datasource.password=${DB_PASSWORD}
    spring.jpa.hibernate.ddl-auto=update

You can see where we are using our environment variables by the token ${}. These variables will be inserted by our build tool gradle at run time when we pass in the appropriate environment variables.

We will see this in action when we run our tests.

Create and Run Testing Database
-------------------------------

We will need to create and configure a testing database for our integration tests. You could manually set one up the way we have in the past, but luckily for us this project contains a ``docker-compose.yml`` file which will allow us to create one quickly and easily.

.. sourcecode:: bash

    docker-compose up -d

This will command will create a new testing database container.

.. admonition:: note

    Check the ``docker-compose.yml`` file. It is creating a testing container on port 5432, before running the command you should double check that nothing is running on that port.

IntegrationTestConfig
---------------------

In the root of our testing directory we will need to add a new configuration file that will serve as the base for our future integration tests.

Create ``src/test/java/org/launchcode/devops/carintegrationtesting/IntegrationTestConfig.java`` and add the following:

.. sourcecode:: java

    // package statement omitted

    import java.lang.annotation.ElementType;
    import java.lang.annotation.Retention;
    import java.lang.annotation.RetentionPolicy;
    import java.lang.annotation.Target;

    import javax.transaction.Transactional;
    import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
    import org.springframework.boot.test.context.SpringBootTest;

    @Transactional
    @SpringBootTest
    @AutoConfigureMockMvc
    @Target(ElementType.TYPE)
    @Retention(RetentionPolicy.RUNTIME)
    public @interface IntegrationTestConfig {}

We won't spend class time delving into these various annotations, but you can find more information by reading their documentation.

Also you can find some general information by referring to the `Spring Testing Web guide <https://spring.io/guides/gs/testing-web/>`_.


Creating CarsControllerTests.java
---------------------------------

We will need to create a test file that will hold the integration tests for our ``/cars`` endpoint.

Create ``car-integration-tests/src/test/java/org/launchcode/devops/carintegrationtesting/controllers/CarsControllerTests.java`` and add the following:

.. sourcecode:: java

    // package statement omitted

    import org.launchcode.devops.carintegrationtesting.IntegrationTestConfig;

    @IntegrationTestConfig
    public class CarsControllerTests {

    @Autowired
    private MockMvc mockRequest;

    @Autowired
    private CarRepository carRepository;

    }

Currently devoid of tests, but contains the two tools we will need for testing our endpoints. We will be using the MockMvc object to build and send HTTP requests and evaluate the HTTP response. We will be using the CarRepository to access our testing database.

Writing Integration Tests
=========================

Now that we have configured our application to run integration tests let's start writing tests.

Looking at the ``CarsController.java`` file we have three endpoints we need to test:

- ``GET /cars``
- ``POST /cars``
- ``GET /cars/{id}``

We will write a test for each of these endpoints in our ``CarsControllerTests.java`` file. 

Test 1: getCars()
-----------------

Let's write the first test for our ``GET /cars`` endpoint:

.. sourcecode:: java

    @Test
    @DisplayName("GET /cars: returns a JSON list representing the cars collection")
    public void getCars() throws Exception {
        mockRequest.perform(MockMvcRequestBuilders.get(CarsController.ROOT_PATH))
            .andExpect(status().isOk())
            .andExpect(content().json("[]"));
    }

Let's break down this test because it's using the MockMvc type we declared earlier.

- ``@Test``: an annotation we have seen many times so far
- ``@DisplayName``: an annotation that allows us to configure the output when the test is run
- method signature: in our integration tests we must include ``throws Exception``
- We are using the mockRequest object to build and make a HTTP GET request to the ROOT_PATH variable of the CarsController file (it happends to be ``/cars``)
- ``.andExpect()`` methods that allow us to check the returned HTTP Response object

For this test our ``.andExpect()`` statements are checking that our HTTP status code is 200, and that the content (body) of our HTTP request is an empty json array.

Test 2: createCar()
-------------------

.. sourcecode:: java

    @Test
    @DisplayName("POST /cars (PartialCar): creates and returns a JSON representation of the new car entity")
    public void createCar() throws Exception {
        Car testCar = new Car("Toyota", "Prius", 10, 20);

        mockRequest.perform(
        MockMvcRequestBuilders
            .post(CarsController.ROOT_PATH)
            .contentType(MediaType.APPLICATION_JSON)
            .content(new ObjectMapper().writeValueAsString(testCar))
        )
        .andExpect(status().isCreated())
        .andExpect(header().exists("Location"))
        .andExpect(jsonPath("$.id").isNumber());
    }

This test is creating a POST request, which requires us to attach a JSON body to our HTTP request which we are doing when we make our MockMvcRequest. Our ``.andExpect()`` methods check that the status code is 201, the headers contain "Location" and finally that the ``.id`` property of the returned JSON body is a number.

Test 3: getCarById()
--------------------

.. sourcecode:: java

    @Test
    @DisplayName("GET /cars/{id}: returns a JSON representation of a car entity matching the id path variable")
    public void getCarById() throws Exception {
        Car testCar = carRepository.save(new Car("Ford", "Mustang", 12, 24));
        mockRequest.perform(MockMvcRequestBuilders.get(CarsController.ROOT_PATH + "/" + testCar.getId()))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.id").value(testCar.getId()))
        .andExpect(jsonPath("$.make").value(testCar.getMake()));
    }

For this test we need to create a new car object in our database, so that we have an id we can make a get with. We are then firing the request with MockMvc and then checking that the HTTP status is 200, the id of the returned JSON car object matches the id of the car we created, and that the make between the JSON and the POJO match.

Running Integration Tests with Gradle Variables
===============================================

Finally we need to run our test using the gradle wrapper and we will need to pass in the environment variables that match our testing database:

.. sourcecode:: bash

    ./gradlew test -D DB_HOST=localhost -D DB_PORT=5432 -D DB_NAME=car_test -D DB_USER=car_test_user -D DB_PASSWORD=password i

From the ``--help`` command for ``./gradlew test``:

    The ``-D`` option or ``--system-prop`` is the option that allows us to set a system property of the JVM when running gradle tasks.

In this case these system properties match the tokens in our ``application.properties`` file that represent our testing database.