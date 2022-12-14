Asegurate de ejecutar lo comandos anteriores 馃憜

**IMPORTANTE** 馃憞

Copia el c贸digo de ayer:

```bash
cp -r ../../05-Food-Delivery-Day-One/01-Food-Delivery/{app,data,app.rb,router.rb} . # trailing dot is important
```

Luego, comprueba que todo todav铆a funciona antes de empezar iniciando tu aplicaci贸n:

```bash
ruby app.rb
```

Entonces, finalmente, puedes ejecutar:

```bash
rake
```

Ahora contin煤a con tu propio c贸digo y sigue agregando funcionalidades al ruteador y haciendo que el `rake` siga saliendo verde.

隆Agreguemos m谩s funcionalidades a nuestro programa de Entrega a Domicilio (Food Delivery)!

Aqu铆 est谩n todas la **acciones de usuario** de nuestra aplicaci贸n:
[] Como empleado, puedo iniciar sesi贸n
[X] Como gerente, puedo agregar un nuevo plato
[X] Como gerente, puedo mostrar la lista de todos platos
[X] Como gerente, puedo agregar un nuevo cliente
[X] Como gerente, puedo mostrar la lista de todos clientes
[X] Como gerente, puedo agregar un nuevo pedido
[X] Como gerente, puedo mostrar la lista de todos los pedidos no entregados
[X] Como repartidor, puedo marcar uno de mis pedidos como entregado
[X] Como repartidor, puedo mostrar la lista de todos mis pedidos no entregados

Por lo tanto, hay dos nuevos componentes:
- **Employees**: empleados
- **Orders**: pedidos

## 1 - `Employee`

### 1.1 - Modelo de `Employee`

Nuestro restaurante tiene dos tipos de empleados: **gerentes** y **repartidores**. Ambos tienen n煤mero de identificaci贸n (id), usuario y contrase帽a. Sin embargo, tienen privilegios diferentes dependiendo de sus roles.

Escribe el c贸digo para implementar esto y haz el crash test del modelo en `irb`. Luego testea tu c贸digo corriendo `rake employee`.

驴Todo en verde? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

### 1.2 - Repositorio de `Employee`

Ahora que tenemos un modelo que representa a nuestros empleados, necesitamos un repositorio para almacenarlos.

Este repositorio se inicializa con una ruta de archivo CSV. Tiene una l贸gica de **solo lectura** ya que solo el administrador de nuestra aplicaci贸n puede crear cuentas (no es necesario crear un m茅todo `add`). La interfaz de este repositorio permite lo siguiente:
- Recuperar a todos los repartidores del repositorio
- Encontrar a un empleado espec铆fico gracias a su n煤mero de identificaci贸n (id)
- Encontrar a un empleado espec铆fico gracias a su usuario

Escribe el c贸digo para implementar esto y haz el crash test de tu repositorio en irb. Debes crear tu propio archivo CSV `employees.csv` dentro de la carpeta `data`. Luego testea tu c贸digo corriendo `rake employee`.

驴Todo en verde? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

### 1.3 - Controlador de `Session`

Implementemos una l贸gica de **login** en nuestra aplicaci贸n.

Queremos tener dos men煤s en el ruteador: uno que muestre la lista de tareas para los gerentes y otra que muestre las de los repartidores. Tambi茅n queremos direccionar la selecci贸n del empleado a la acci贸n en el controlador correspondiente.

Para ello introduciremos la noci贸n de una **session**. A nivel del ruteador, almacenaremos al usuario logueado en una sesi贸n.

La secuencia de inicio de sesi贸n debe ser de la siguiente manera:

```bash
> username?
paul
> password?
blablabla
Wrong credentials... Try again!
> username?
paul
> password?
secret
Welcome Paul!
```

Despu茅s de haber iniciado sesi贸n, ver谩s un tablero de comando **de acuerdo a tu rol en la empresa**.

Escribe el c贸digo para implementar este comportamiento.

No hay rake para esta parte del desaf铆o. Corre tu aplicaci贸n ejecutando el siguiente comando en la Terminal:

```bash
ruby app.rb
```

驴Todo est谩 funcionando bien? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

## 2 - `Order`

### 2.1 - Modelo de `Order`

Nuestro restaurante toma pedidos, as铆 que tenemos que representar lo que es un pedido.


El pedido es lo que une a todos los elementos. Cada pedido tiene un n煤mero de identificaci贸n (id), un plato, un cliente, un empleado y un booleano `delivered` para registrar si ha sido entregado.

Escribe el c贸digo para implementar esto y haz el crash test del modelo en `irb`. Luego testea tu c贸digo corriendo `rake order`.

驴Todo en verde? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

### 2.2 - Repositorio de `Order`

Ahora que ya tenemos un modelo que representa a nuestros pedidos, tenemos la necesidad de un repositorio para almacenarlos.

Este repositorio se inicializa con una ruta de archivo CSV, lee/escribe los pedidos del archivo CSV y los almacena en memoria. La interfaz del repositorio permite lo siguiente:
- Agregar un nuevo pedido
- Recuperar todos los pedidos no entregados

Ya que nuestro pedido tiene las **instancias** `meal`, `customer` y `employee`, tenemos que inicializar nuestro repositorio de pedidos, el de los platos (meals), el de los clientes (customers) y el de los empleados (employees).

Escribe el c贸digo para implementar esto y haz el crash test del repositorio en `irb`. Tienes que crear tu propio archivo  CSV `orders.csv` dentro de la carpeta `data`. Luego testea tu c贸digo corriendo `rake order`.

**Importante**: los tests de `order_repository` que corre `rake` **solo funcionan si defines los par谩metros en `#initialize` en el mismo orden que el que est谩 en los tests**:

```ruby
class OrderRepository
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    # [...]
  end

  # [...]
end
```

驴Todo en verde? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

### 2.3 Controlador de `Order`

Vayamos al controlador. Las siguientes son las **acciones de usuario** que queremos implementar:
- Como gerente, puedo agregar un pedido
- Como gerente, puedo mostrar la lista de todos los pedidos que no han sido entregados
- Como repartidor, puedo marcar uno de mis pedidos como entregado
- Como repartidor, puedo mostrar la lista de todos mis pedidos no entregados

隆Recuerda que el rol del controlador es delegar el trabajo a los otros componentes de nuestra aplicaci贸n (modelo, repositorio y vistas)!

Comienza escribiendo el **pseudoc贸digo** separando cada acci贸n de usuario en pasos b谩sicos y delegando cada uno de ellos a un componente (modelo, repositorio, vista). Luego escribe el c贸digo correspondiente. Crea la vista y escribe su c贸digo paso por paso.

Para testear el controlador, conectalo a tu aplicaci贸n instanciandolo en `app.rb` y pas谩ndoselo al ruteador. Luego haz el crash test del c贸digo corriendo tu aplicaci贸n:

```bash
ruby app.rb
```

`rake order` tambi茅n te deber铆a ser de utilidad en estos pasos. 隆Sigue la gu铆a!

Asegurate que las cuatro acciones de usuario para pedidos funcionen bien antes de trabajar en la siguiente funcionalidad.

**Importante**: los tests de `orders_controller` que corre `rake` **solo funcionan si defines los par谩metros en `#initialize` en el mismo orden que el que est谩 en los tests**:

```ruby
class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    # [...]
  end

  # [...]
end
```

**Atenci贸n** 鈿狅笍 Dado que los **ids** no empiezan necesariamente por 1 y no son necesariamente continuos, es una **mala pr谩ctica pedir a un usuario un id**.

Imaginemos que tenemos 3 meals, con id `1234`, `4242` y `987654`. **No** queremos mostrar:

```bash
1234 - pizza
4242 - burger
987654 - salad

Please choose an id:
>
```

Pero queremos utilizar **铆ndices** para mejorar la experiencia del usuario:

```bash
1 - pizza
2 - burger
3 - salad

Please choose an index:
>
```

驴Todo en verde? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

## 3 - Opcionales

### 3.1 - Implementa las acciones `edit` y `destroy` para los pedidos.

Por ahora en nuestra aplicaci贸n los gerentes a煤n no pueden editar o borrar pedidos actuales.

Implementa las siguientes acciones de usuarios adicionales:
- Como gerente, puedo editar un pedido actual
- Como gerente, puedo borrar un pedido actual

驴Listo? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

### 3.2 Oculta la contrase帽a del/de la usuario/a

Por ahora, la contrase帽a se guarda directamente en el CSV y es cualquier persona la puede ver 驴Crees que esto es buena idea? 驴C贸mo podemos cambiar esto?

驴Listo? 隆Qu茅 bueno! Es hora de hacer `git add`, `commit` y `push`.

隆Has terminado el Food Delivery!
