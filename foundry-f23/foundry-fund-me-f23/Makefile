-include .env
build: ; forge build
deploy-sepolia:
    forge script script/DeployFundMe --rpc-url $(Sepolia_Url) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)make  -vvvv