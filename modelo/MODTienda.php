<?php
/**
*@package pXP
*@file gen-MODTienda.php
*@author  (admin)
*@date 21-12-2017 12:00:18
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTienda extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTienda(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='shop.ft_tienda_sel';
		$this->transaccion='SHP_SHO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tienda','int4');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTienda(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='shop.ft_tienda_ime';
		$this->transaccion='SHP_SHO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTienda(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='shop.ft_tienda_ime';
		$this->transaccion='SHP_SHO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tienda','id_tienda','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTienda(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='shop.ft_tienda_ime';
		$this->transaccion='SHP_SHO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tienda','id_tienda','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>