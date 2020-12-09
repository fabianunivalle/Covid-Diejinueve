
/*
TRIGGER PARA INSERTAR DATOS EN LA TABLA DE INFORMES
*/

/*============================================================================================================
============================================================================================================
CREA LA FUNCION sp_inserta_informe() QUE CAMBIA EL ESTADO DE UNA FACTURA QUE HAYA RECIBIDO UN PAGO
============================================================================================================
============================================================================================================*/																	

--DROP FUNCTION sp_inserta_informe() 
CREATE FUNCTION sp_inserta_informe() 
   RETURNS trigger AS
$$
DECLARE v_usrio_id integer;
begin

v_usrio_id	:= (select max(id) from public.usuario_usuario );

insert into public.informe_real(fecha_informe,paciente_id,genero)

select a.date_joined, a.id,a.genero 
from public.usuario_usuario a
where a.id = v_usrio_id;

return new;
end
$$
LANGUAGE PLPGSQL;

/*============================================================================================================
============================================================================================================
BORRA EL TRIGGER TR_Cambia_estado_factura EN CASO DE SER NECESARIO
============================================================================================================
============================================================================================================*/																	
	
DROP TRIGGER TR_inserta_informe
   ON public.usuario_usuario 
   
/*============================================================================================================
============================================================================================================
CREA EL TRIGGER TR_Cambia_estado_factura
============================================================================================================
============================================================================================================*/																	
CREATE TRIGGER TR_inserta_informe 
after insert
   ON public.usuario_usuario 
   FOR EACH ROW
       EXECUTE PROCEDURE sp_inserta_informe();
