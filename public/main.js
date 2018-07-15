window.addEventListener('DOMContentLoaded', () => {
  const onDeleteButtonClicked = obj => {
    console.log("hello world")
    const xhr = new XMLHttpRequest();
    console.warn(xhr);
    console.warn(obj.getAttribute("data"));
    const id = obj.getAttribute("data");
    const token = obj.getAttribute("token");
    console.log(token);

    var formData = new FormData();
    formData.append("id", id);
    formData.append("_csrf", token);
    console.log(formData.entries());

    xhr.open("post", "/destroy");
    xhr.send(formData);
    obj.parentNode.parentNode.removeChild(obj.parentNode);
  }

  const deleteButtons = document.getElementsByClassName('delete');
  for(let i = 0; i < deleteButtons.length; i++) {
    deleteButtons[i].addEventListener("click", () => onDeleteButtonClicked(deleteButtons[i]))
  }
});