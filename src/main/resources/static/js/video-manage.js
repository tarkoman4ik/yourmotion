function sendSelectedItem(id){
    var sender = document.getElementById(id);
    var xhr = new XMLHttpRequest();
    alert(sender.options[sender.selectedIndex].value.toString());
    xhr.open("POST", "/video/delete/"+sender.options[sender.selectedIndex].value.toString(), true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        value: value
    }));
}