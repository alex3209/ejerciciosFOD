program infoIngresos;
type
  cadena20 = string[20];

  comision = record
    codigo: integer;
    nombre: cadena20;
    comision: real;
  end;

  archivo = file of comision;

var
  arch: archivo;
  c: comision;
begin
  assign(arch, 'comisiones');
  rewrite(arch);

  { Empleado 1 }
  c.codigo := 1; c.nombre := 'Juan'; c.comision := 100; write(arch, c);
  c.codigo := 1; c.nombre := 'Juan'; c.comision := 200; write(arch, c);
  c.codigo := 1; c.nombre := 'Juan'; c.comision := 50;  write(arch, c);

  { Empleado 2 }
  c.codigo := 2; c.nombre := 'Ana'; c.comision := 70; write(arch, c);
  c.codigo := 2; c.nombre := 'Ana'; c.comision := 30; write(arch, c);

  { Empleado 3 }
  c.codigo := 3; c.nombre := 'Luis'; c.comision := 120; write(arch, c);

  close(arch);
end.
