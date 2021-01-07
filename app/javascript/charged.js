function charge() {
  const itemPrice = document.getElementById("item-price");
  const addTax = document.getElementById("add-tax-price");
  const Profit = document.getElementById("profit")
  
  itemPrice.addEventListener("input", () => {
    const inputPrice = itemPrice.value;
    addTax.innerHTML = Math.floor(inputPrice * 0.1);
    Profit.innerHTML = inputPrice - Math.floor(inputPrice * 0.1);
  });

}
window.addEventListener("load", charge);