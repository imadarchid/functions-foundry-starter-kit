include .env
-include ${FCT_PLUGIN_PATH}/makefile-sandbox

simulate-don:
	./don-setup.sh && \
	npx tsx ./don/run.ts

deploy-consumer:
	forge script script/consumer/DeployConsumer.s.sol:DeployConsumer --rpc-url ${RPC_URL} --broadcast -vv --private-key ${PRIVATE_KEY}

create-subscription:
	forge script script/subscriptions/CreateSubscription.s.sol:CreateSubscription --rpc-url ${RPC_URL} --broadcast --private-key ${PRIVATE_KEY} -vv

fund-subscription:
	forge script script/subscriptions/FundSubscription.s.sol:FundSubscription --rpc-url ${RPC_URL} --broadcast --private-key ${PRIVATE_KEY} -vv

add-consumer-to-subscription:
	forge script script/consumer/AddConsumerToSubscription.s.sol:AddConsumerToSubscription --rpc-url ${RPC_URL} --broadcast --private-key ${PRIVATE_KEY} -vv

send-consumer-request:
	forge script script/consumer/Interactions.s.sol:Interactions --sig "sendRequest()" --rpc-url ${RPC_URL} --broadcast --private-key ${PRIVATE_KEY} -vv

run-all:
	make deploy-consumer && \
	make create-subscription && \
	make fund-subscription && \
	make add-consumer-to-subscription && \
	make send-consumer-request

get-latest-response:
	forge script script/consumer/Interactions.s.sol:Interactions --sig "getLatestResponse()" --rpc-url ${RPC_URL} --broadcast --private-key ${PRIVATE_KEY} -vv
