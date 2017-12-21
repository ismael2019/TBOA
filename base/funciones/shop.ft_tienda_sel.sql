CREATE OR REPLACE FUNCTION "shop"."ft_tienda_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Tienda
 FUNCION: 		shop.ft_tienda_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'shop.ttienda'
 AUTOR: 		 (admin)
 FECHA:	        21-12-2017 12:00:18
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				21-12-2017 12:00:18								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'shop.ttienda'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'shop.ft_tienda_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SHP_SHO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		21-12-2017 12:00:18
	***********************************/

	if(p_transaccion='SHP_SHO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						sho.id_tienda,
						sho.nombre,
						sho.estado_reg,
						sho.usuario_ai,
						sho.fecha_reg,
						sho.id_usuario_reg,
						sho.id_usuario_ai,
						sho.fecha_mod,
						sho.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from shop.ttienda sho
						inner join segu.tusuario usu1 on usu1.id_usuario = sho.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sho.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SHP_SHO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		21-12-2017 12:00:18
	***********************************/

	elsif(p_transaccion='SHP_SHO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tienda)
					    from shop.ttienda sho
					    inner join segu.tusuario usu1 on usu1.id_usuario = sho.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sho.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
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
ALTER FUNCTION "shop"."ft_tienda_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
