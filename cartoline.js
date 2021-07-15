//colora il pallino della riga corrispondente quando viene cliccata un'area
function gestoreEvidenzia(area){  //area= zona1.1
    try {

        for (var i = 0; i < nodiPallini.length; i++){ //scorre tutti i pallini 
            if(nodiPallini[i].getAttribute("class")== "colorato") { //se ce ne sono di attivi 
                nodiPallini[i].classList.remove("colorato"); //li disattiva
            }
            if(nodiPallini[i].getAttribute("name")== "ID#" + area) { //se il nome del pallino è uguale all'id dell'area (con ID#)
                nodiPallini[i].setAttribute("class","colorato"); //gli attribuisce la classe per attivarlo
            }
        }
    } catch(e) {
        alert("gestoreEvidenzia()"+e);   
    }                                     
}

//fa comparire la versione estesa quando viene cliccata l'abbreviazione e viceversa
function gestoreAbbreviazioni(){ 
    try {
        
        var esteso = this.id; //prende il valore dell'id
        var abbreviazione = this.textContent; //prende il contenuto testuale
        this.textContent = esteso; //li scambia
        this.setAttribute("id", abbreviazione);

    } catch(e) {
        alert("gestoreAbbreviazioni()"+e);   
    }                                     
}

var nodiPallini;
var nodiAbbreviazioni;

function gestoreLoad(){
    try {
        nodiPallini = document.getElementsByTagName("a"); //onclick già in html

        nodiAbbreviazioni = document.getElementsByTagName("i");

        for (var i = 0; i < nodiAbbreviazioni.length; i++){
            nodiAbbreviazioni[i].onclick = gestoreAbbreviazioni;

		}


    } catch(e) {
		alert("gestoreLoad" + e); 
	}
}

window.onload = gestoreLoad;