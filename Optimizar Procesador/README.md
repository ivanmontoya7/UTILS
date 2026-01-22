# ⚡ Optimizar Procesador

---

## 🔧 Editor del Registro

1. Abre el Editor del Registro buscando `regedit` en la de la barra de búsqueda de Windows.

2. Escribe en la barra superior del Editor del Registro:
   ```
   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7
   ```

3. En el panel central, haz doble clic en **Attributes**.

4. Cambia el valor de `1` a `2`, y deja la base en **Hexadecimal**.

5. Cierra el Editor del Registro.

---

## ⚙️ Configuración de Energía

1. Abre el **Panel de Control** buscándolo en la de la barra de búsqueda de Windows.

2. Dirígete a **Sistema** y posteriormente a **Opciones de Energía**.

3. Haz clic en *"Cambiar la configuración del plan"* de tu plan activo.

4. Haz clic en *"Cambiar la configuración avanzada de energía"*.

5. Expande *"Administración de energía del procesador"*.

6. Expande *"Modo de mejora del rendimiento de procesador"*.

7. Establece ambas opciones (**Con batería** y **Conectado**) a *"Deshabilitado"*.

8. Aplica y acepta.