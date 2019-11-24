var mymap = L.map('mapid').setView([21.041670,105.788642], 15);
L.tileLayer('https://maps.vietmap.vn/tm6/{z}/{x}/{y}@2x.png?apikey=f50f96fd875c023e6fd8acac6d9a7e0d15699071d3259542', {
    attribution: 'Map data &copy; VMap',
    maxZoom: 13
}).addTo(mymap);