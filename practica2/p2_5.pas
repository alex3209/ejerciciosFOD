{Se cuenta con un archivo de productos de una cadena de venta de alimentos 
congelados.
De cada producto se almacena: código del producto, nombre, descripción, 
stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de 
la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock 
del archivo
maestro. La información que se recibe en los detalles es: código de producto y 
cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock 
disponible por
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el 
mismo
procedimiento de actualización, o realizarlo en un procedimiento separado 
(analizar
ventajas/desventajas en cada caso).

Nota: todos los archivos se encuentran ordenados por código de productos. 
En cada detalle
puede venir 0 o N registros de un determinado producto.}


program untitled;
const
	valoralto = 9999;
	dimF = 30;
type
	producto = record
		codigo:integer;
		nombre:string;
		descripion:string;
		stockDisponible:integer;
		stockMin:integer;
		precio:real;
	end;
	
	venta = record
		codigo:integer;
		cantVendidas:integer;
	end;
	
	detalle = file of venta;
	maestro = file of producto;
	arc_detalle = array[1..dimF] of detalle;
	reg_detalle = array[1..dimF] of venta;

procedure leerM(var mae:maestro; var m:producto);
begin
	if (not eof(mae)) then read(mae,m)
	else m.codigo := valoralto;
end;

procedure leerD(var det:detalle; var d:venta);
begin
	if (not eof(det)) then read(det,d)
	else d.codigo := valoralto;
end;
	
	
var
	deta:arc_detalle;
	reg_det:reg_detalle;
	mae:maestro;
	regm:producto;

BEGIN
	
	
END.

