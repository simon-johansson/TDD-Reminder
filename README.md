# TDD Reminder

> OSX status bar application to help you stick to the test-driven development cycle *red-green-refactor*

Made with <3 and [nw.js](http://nwjs.io/).

## Starting the app
**TDD Reminder** shows up as a colord dot in your status bar, reminding you of what phase in the *red-green-refactor* cycle you are currently in.

![Tray icon](promo/tray.png)

Unsure of what you should be doing? Just have a peak at the status bar.

Dot                       | What you should be doing
------------------------- | ------------------------------------------------
![](promo/red_dot.png)    | Write a faling unit test
![](promo/green_dot.png)  | Write production code that makes your test pass
![](promo/blue_dot.png)   | Clean up the mess you just made

## Moving to the next phase
Click on the dot, this will open the **TDD Reminder** window. Clicking somewhere inside the colored box will move you to the next phase.

![Demo of transitions](promo/demo.gif)

## Why?
Sticking to the [laws of TDD](http://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html) isn’t always trivial for a number of different reasons.

<!-- Sticking to the [laws of TDD](http://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html) isn’t always easy and straight forward. You might find yourself skipping or prolonging phases of the *red-green-refactor* cycle in the hopes of progressing faster or start taking the laws for granted and becoming too lenient, blurring the lines between the different phases. -->

**TDD Reminder** might help you in one of the following ways:

* Visualising the transitions beween the three phases makes the bouderies between them sharp and clear.
* It becomes really hard to stray off the beaten track when you are constantly reminded of what you should be doing.
* By clicking on the dot and taking the decision to move to the next phase, you are making a mini promise to yourself that you will be reluctant to break.

## Installing
...

## REST interface
**TDD Reminder** spins up a server in the background on ``http://localhost:22789`` which accepts POST requests. By sending a JSON object with the key of ``state`` and the value of either ``red``, ``green`` or ``refactor`` you are able to change the current phase.

**Using curl**
```bash
# This would change the app state to "refactor", making the dot blue
$ curl -H "Content-Type: application/json" -X POST -d '{"state":"refactor"}' http://localhost:22789/
```

**Using node.js with the [request](https://github.com/request/request) module**
```javascript
// This would change the app state to "green"
var request = require('request');
request.post('http://localhost:22789', {form: {state:'green'}});
```


You could for example set up your test runner to change the phase to "green" if you have a failing test (which would mean that you should write production code to make that test pass). Or change the phase to "refactor" if all your tests are passing.

### Changing the server port
Specify a custom port by setting the environment variable ``TDD_REMINDER_PORT``. Putting the following line in your `.bashrc`, `.zshrc` or equivalent shell config file will start the server on port 3456:

```bash
export TDD_REMINDER_PORT="3456"
```

## License

MIT

