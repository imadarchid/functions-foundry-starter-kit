
# Chainlink Functions Foundry Starter Kit

This starter kit allows developers to develop and test functions locally using Foundry. It relies on `functions-toolkit`, an NPM package with a collection of tools that can be used for working with Chainlink Functions.

ℹ️ Due to the asynchronous nature of Chainlink Functions, the scripts are broadcasted to the local RPC. All contracts are deployed by Anvil's default sender account.
## Prerequistes

To run this project, please ensure that you have the following:

- Node.js 18.18+ and Deno 1.36.0+
- Foundry v1.0.0
- An .env file with similar structure to .env.example




## Project Structure

A little bit more details on the project structure. Feel free to suggest improvements or other use cases.

* `don`: A folder containing a modified version of the functions-toolkit package. Instead of creating a new Ganache server, we listen to the local Anvil node.
* `script`
    * `consumer`: Contains a deployment script for the sample consumer contract. It also has helper scripts to add the consumer to a subscription, and interact using `sendRequest` and `getLatestResponse`.
    * `subscriptions`: Scripts to manage the subscriptions (create, fund, delete...)
* `HelperConfig`: Sets up the required network configuration (Router, DON, Link Token) to be used by other scripts.
* `src`: Sample consumer contract and interface for the Link token.


## Using the starter kit

First you need to run your local anvil.

```sh
make fct-anvil
```
Then you can run the setup scripts which will allow you to deploy a consumer, create a subscription, fund it, add the consumer to the subscription, and make a request

```sh
make run-all
```
To get the latest response from the simulated don.
```sh
make get-latest-response
```


## Inspiration
- [Functions Toolkit](https://github.com/smartcontractkit/functions-toolkit)
 - [Foundry Chainlink Toolkit](https://github.com/smartcontractkit/foundry-chainlink-toolkit)
 - [Foundry Devops](https://github.com/Cyfrin/foundry-devops)

## Roadmap

- Add tests.
- Add support for using the same scripts to deploy on other chains. 

