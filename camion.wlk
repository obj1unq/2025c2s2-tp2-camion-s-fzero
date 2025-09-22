import cosas.*

object camion {
	const property cosas = #{}
	const pesoTara = 1000
		
	method cargar(unaCosa) {
		self.validarCarga(unaCosa)
		cosas.add(unaCosa)
	}
	method descargar(unaCosa) {
		self.validarDescarga(unaCosa)
		cosas.remove(unaCosa)
	}
	method validarCarga(unaCosa) {
	  if (cosas.contains(unaCosa)){
		self.error("No se puede cargar un elemento ya cargado")
	  }
	}
	method validarDescarga(unaCosa) {
	  if (!cosas.contains(unaCosa)){
		self.error("No se puede remover un elemento que no esta cargado")
	  }
	}
	method laCargaEsPar() {
	  return (cosas.sum({cosa => cosa.peso()}) % 2 == 0)
	}
	method algunoPesa(kg) {
	  return cosas.any({cosa => cosa.peso() == kg}) 
	}
	method estaExecedidoDePeso() {
	  return pesoTara + cosas.sum({cosa => cosa.peso()}) > 2500
	}
	method cosaConNivelDePeligrosidad(nivel) {
	  return cosas.find({ cosa => cosa.nivelPeligrosidad() == nivel })
	}
	method cosasQueSuperanNivelDePeligrosidad(nivel) {
	  return cosas.filter({ cosa => cosa.nivelPeligrosidad() > nivel })
	}
	method superanElNivelDePeligrosidadDe(unaCosa) {
	  return self.cosasQueSuperanNivelDePeligrosidad(unaCosa.nivelPeligrosidad())
	}
	method puedeCircularEnRuta(nivel) {
	  return not self.estaExecedidoDePeso() && #{} == self.cosasQueSuperanNivelDePeligrosidad(nivel)
	}
	method tieneAlgoQuePesaEntre(primerValor, segundoValor) {
	  return cosas.any({cosa => cosa.peso() >= primerValor && cosa.peso() <= segundoValor })
	}
	method pesoDeLasCosas() {
	  return cosas.map({cosa => cosa.peso()})
	}
	method cantTotalDeBultos() {
	  return cosas.sum({cosa => cosa.cantBultos()})
	}
	method accidente() {
		cosas.forEach({cosa => cosa.accidente()})
	}
	method transportar(destino, camino){
		self.validarViaje(camino)
		destino.almacenar(cosas)
		cosas.clear()
	}
	method validarViaje(camino) {
	  if (!camino.puedeViajar(self)){
		self.error("El camion no puede viajar por este camino, no cumple con los requisitos.")
	  }
	}
} 
object almacen {
	const property almacenado = #{}
	method almacenarUnaCosa(unaCosa) {
		almacenado.add(unaCosa)
	}
	method almacenar(cosas) {
		almacenado.addAll(cosas)
	}
}

object ruta9 {
	method puedeViajar(vehiculo) {
		return vehiculo.puedeCircularEnRuta(20)
  	}
}
object caminosVecinales {
  	var pesoMaximoPermitido = 2000
  	method pesoMaximoPermitido(_pesoMax) {
		pesoMaximoPermitido = _pesoMax
  	}
  	method puedeViajar(vehiculo) {
		return !(vehiculo.pesoDeLasCosas().sum() > pesoMaximoPermitido) &&  !vehiculo.estaExecedidoDePeso() 
  	}
}