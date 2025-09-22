object knightRider {
	method accidente() {
	  
	}
	method cantBultos() { return 1 }
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}

object arenaAGranel {
	var property peso = 0
    method accidente() {
	  peso += 20 
  	}
	method cantBultos() { return 1 }
	method nivelPeligrosidad() { return 1 } 
}

object bumblebee {
	var property esAuto = false
	method accidente() {
		esAuto = !esAuto
  	}
	method cantBultos() { return 2 }
	method peso() { return 800 }
	method nivelPeligrosidad() {
		if (esAuto) { return 15 }
		else{ return 30 }
	}
}

object paqueteDeLadrillos {
	const pesoXLadrillo = 2
	var property cantDeLadrillos = 0
	method accidente() {
		cantDeLadrillos = (cantDeLadrillos - 12).max(0)
  	}
	method cantBultos() { 
		if (cantDeLadrillos <= 100){
			return 1
		} 
		else if ((cantDeLadrillos > 100) && cantDeLadrillos < 301){
			return 2
		}
		else{
			return 3
		}
    }

	method peso() { return pesoXLadrillo * cantDeLadrillos } 
	method nivelPeligrosidad() { return 2 }
}

object bateriaAntiAerea {
	var property tieneMisiles = false
	method accidente() {
		self.tieneMisiles(false)
  	}
	method cantBultos() { 
		if (tieneMisiles){ return 2}
		else{ return 1 }
	}
	method peso() { 
		if (tieneMisiles){ return 300 }
		else { return 200}
		}
	method nivelPeligrosidad() { 
		if (tieneMisiles){ return 100 }
		else { return 0}
	}
}

object residuosRadioactivos {
	var property peso = 0
  	method accidente() {
	   peso += 15
 	}	
	method cantBultos() { return 1 }
	method nivelPeligrosidad() { return 200 }
}

object contenedorPortuario {
  const peso = 100
  const cantBultosPropio = 1
  const cosas = #{}
  method accidente() {
	cosas.forEach({cosa => cosa.accidente()})
  }
  method cantBultos() { return cantBultosPropio + cosas.sum({cosa => cosa.cantBultos()}) }
  method cargar(unaCosa){
	//self.validarCarga(unaCosa)
    cosas.add(unaCosa)
  }
  method descargarTodo() {
	//self.validarDescarga(unaCosa)
	cosas.clear()
  }
  method peso () {
	return peso + cosas.sum({cosa => cosa.peso()}) 
  }
  method nivelPeligrosidad() {
	return cosas.map({ cosa => cosa.nivelPeligrosidad()}).maxIfEmpty({0})
  }
}

object embalajeDeSeguridad {
  var cosaEmbalada = null
  method accidente() {
	
  }
  method cantBultos() { return 2 }
  method cosaEmbalada(_cosaEmbalada){
	cosaEmbalada = _cosaEmbalada
  }
  method peso() {
	return cosaEmbalada.peso()
  }
  method nivelPeligrosidad() {
	return cosaEmbalada.nivelPeligrosidad() / 2
  }
}