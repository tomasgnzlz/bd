use ventapromoscompleta;
-- 1. El precio de un artículo en promoción nunca debe ser mayor o igual al precio habitual de venta (el de la tabla artículos).
delimiter $$
drop trigger if exists precioArtPromociones$$
create trigger precioArtPromociones before update
on articulos
for each row
begin 
	declare precios double;
		set precio = (select precioventa from articulos);
        if old.precioventa >= now.precioventa  then
			-- el update de los precios
		else
			signal sqlstate '45000' set message_text="ERROR, El precio de ";
		end if;
end 
delimiter ;
