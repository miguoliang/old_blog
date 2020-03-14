---
layout: post
title: How to Fix Testing Order in Angular with Jasmine
description: This tutorial talks about how to use Jasmine to test an entire & context relative workflow. Update to Angular 9 and Jasmine 3.
image: /assets/2020-02-25-how-to-fix-testing-order-in-angular-with-jasmine/banner.jpg
categories:
    - code
tags:
    - testing
---

> Updated to Angular 9 and Jasmine 3

## Introduction

Jasmine is an Unit Testing framework for Javascript, and Angular uses it. Angular also use Krama to manage the environment configuration of unit testing.

By default, Jasmine executes testing methods in random order. It means that the sequence of test methods is meaningless. Independent testing methods work well in random order, and Context-related testing methods only work well in a particular order.

Suppose that we plan to test the entire authentication workflow, I will show you how to make these testing stable and reliable.

## A Classic and Simple Authentication Flow

1. Register a non-existing account.
2. Resend Activation Token when a user does not receive the email verification.
3. Activate the account.
4. Login as the account.
5. Try to register an existing account.

As the above workflow, we need to:

1. Generate a random email as the username of an account and store it for the future use.
2. Store the activation token by RESTful registration API.
3. Confirm the response status of the resend activation token RESTful API is 200
4. Activate the account we just created by RESTful activation API with the activation token we only stored at *Step 2*.
5. Get the access token by RESTful login API.
6. Call the RESTful registration API again with the same username we generated in *Step 1*, and expect an error response about the account we just registered.

## Writing Testing Cases

Suppose we have a HTTP service in Angular, like this:

```typescript
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { LoginRequest } from '../models/http/request/login-request';
import { url } from '../utils/http';
import { LoginResponse } from '../models/http/response/login-response';
import { Customer } from '../models/customer';
import { RegisterResponse } from '../models/http/response/register-response';

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  constructor(private httpClient: HttpClient) { }

  register(args: Customer) {
    return this.httpClient.post<RegisterResponse>(url('auth/register'), args, { observe: 'response' });
  }

  resendActivationToken(email: string) {
    return this.httpClient.post<any>(url(`auth/resend-activation-token/${email}`), null, { observe: 'response' });
  }

  activate(email: string, token: string) {
    return this.httpClient.post<any>(url(`auth/activate/${email}/${token}`), null, { observe: 'response' });
  }

  login(type: string, args: LoginRequest) {
    return this.httpClient.post<LoginResponse>(url(`auth/login?type=${type}`), args, { observe: 'response' });
  }

}
```

Now we need to test the entire workflow, we write testing cases in a spec file, like this:

```javascript
import { TestBed } from '@angular/core/testing';

import { AuthenticationService } from './authentication.service';
import { CustomerProvider } from '../models/customer';
import { HttpClientModule } from '@angular/common/http';
import * as _ from 'lodash';

const cryptoRandomString = require('crypto-random-string');

fdescribe('AuthenticationService', () => {
  let service: AuthenticationService;

  let testEmail: string;
  let testActivationToken: string;

  beforeAll(() => {
    const username = cryptoRandomString({ length: 10 });
    const domain = cryptoRandomString({ length: 10 });
    testEmail = `${username}@${domain}.com`;
  });

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientModule]
    });
    service = TestBed.inject(AuthenticationService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should register successfully', (done: DoneFn) => {

    service.register({
      email: testEmail,
      name: 'Mi Guoliang From Dashboard',
      provider: CustomerProvider.local,
      contactNo: '18620398354',
      password: 'atp0769AT'
    }).subscribe(resp => {
      expect(resp.status).toBe(200);
      expect(_.isString(resp?.body?.token)).toBeTrue();
      testActivationToken = resp?.body?.token;
      done();
    }, fail);
  });

  it('should resend the activation token', (done: DoneFn) => {
    service.resendActivationToken(testEmail).subscribe(resp => {
      expect(resp.status).toBe(200);
      done();
    }, fail);
  });

  it('should activate the account', (done: DoneFn) => {
    service.activate(testEmail, testActivationToken).subscribe(resp => {
      expect(resp.status).toBe(200);
      done();
    }, fail);
  });

  it('should login successful', (done: DoneFn) => {
    service.login('c', {
      username: testEmail,
      password: 'atp0769AT'
    }).subscribe(resp => {
      expect(resp.status).toBe(200);
      expect(resp.body?.name === 'Mi Guoliang From Dashboard').toBeTrue();
      expect(resp.body?.email === testEmail).toBeTrue();
      expect(resp.body?.contactNo === '18620398354').toBeTrue();
      expect(resp.body?.token?.length > 0).toBeTrue();
      done();
    }, fail);
  });

});
```

As we discussed at the beginning of this tutorial. By default, the execution order of testing methods is random in Jasmine. We can not make sure that the login testing method is running in the first order strictly.

## Make the Running Order Being the Same as Writting Order (Disable the Random Ordering)

Edit the *krama.conf.js* file at the root directory of your Angular project, and add Jasmine configuration codes in the **client** node:

```javascript
// Karma configuration file, see link for more information
// https://karma-runner.github.io/1.0/config/configuration-file.html

module.exports = function (config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine', '@angular-devkit/build-angular'],
    plugins: [
      require('karma-jasmine'),
      require('karma-chrome-launcher'),
      require('karma-jasmine-html-reporter'),
      require('karma-coverage-istanbul-reporter'),
      require('@angular-devkit/build-angular/plugins/karma')
    ],
    client: {
      clearContext: false, // leave Jasmine Spec Runner output visible in browser
      ////////////////////////
      jasmine: {
        random: false // disable the random running order
      }
      ////////////////////////
    },
    coverageIstanbulReporter: {
      dir: require('path').join(__dirname, './coverage/mrrs-dashboard-frontend-v2'),
      reports: ['html', 'lcovonly', 'text-summary'],
      fixWebpackSourcePaths: true
    },
    reporters: ['progress', 'kjhtml'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome'],
    singleRun: true,
    restartOnFileChange: true
  });
};
```

That's it!

## Conclusion

Integration testing is necessary today. An excellent practice for integration testing is working with a BDD (Behavior-Driven Development) testing framework. And Jasmine is one of them in front-end development. Most of the testing framework executes testing methods in random order by default for performance reason. What we need to do is only configure it to satisfy our requirements.
