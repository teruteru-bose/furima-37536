window.addEventListener('input', () => {

  const price = document.getElementById("item-price")
    const inputValue1 = price.value

  const addTax = document.getElementById("add-tax-price")
    const inputValue2 = Math.floor(inputValue1 * 0.1)
    addTax.innerHTML = inputValue2

  const profit = document.getElementById("profit")
    const inputValue3 = Math.floor(inputValue1 - inputValue2)
    profit.innerHTML = inputValue3

});