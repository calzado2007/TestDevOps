fetch('/api/hola')
  .then(response => response.text())
  .then(data => {
    document.getElementById('hola-mundo').innerText = data;
  })
  .catch(error => console.error(error));
