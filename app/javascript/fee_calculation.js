window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput){ return false;}
  priceInput.addEventListener("input", () => {
  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
  const addProfitDom =document.getElementById("profit")
  addProfitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1))
  });
});