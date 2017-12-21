CREATE OR REPLACE FUNCTION "shop"."ft_tienda_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Tienda
 FUNCION: 		shop.ft_tienda_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'shop.ttienda'
 AUTOR: 		 (admin)
 FECHA:	        21-12-2017 12:00:18
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				21-12-2017 12:00:18								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'shop.ttienda'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tienda	integer;
			    
BEGIN

    v_nombre_funcion = 'shop.ft_tienda_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SHP_SHO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-12-2017 12:00:18
	***********************************/

	if(p_transaccion='SHP_SHO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into shop.ttienda(
			nombre,
			estado_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre,
			'activo',
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_tienda into v_id_tienda;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tiendas almacenado(a) con exito (id_tienda'||v_id_tienda||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tienda',v_id_tienda::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SHP_SHO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-12-2017 12:00:18
	***********************************/

	elsif(p_transaccion='SHP_SHO_MOD')then

		begin
			--Sentencia de la modificacion
			update shop.ttienda set
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tienda=v_parametros.id_tienda;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tiendas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tienda',v_parametros.id_tienda::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SHP_SHO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-12-2017 12:00:18
	***********************************/

	elsif(p_transaccion='SHP_SHO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from shop.ttienda
            where id_tienda=v_parametros.id_tienda;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tiendas eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tienda',v_parametros.id_tienda::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "shop"."ft_tienda_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
