const erc721Sample = artifacts.require("Bridge721");//Burada .sol uzantılı dosyanın ismi değil de contrat'ın ismini yazıyoruz.

module.exports = function (deployer) {
  deployer.deploy(erc721Sample);
};
