namespace control_rutas_API.Models
{
    public class Resultado
    {
        public bool Exito { get; set; } = false;
        public string Mensaje { get; set; } = "";
        public object Data { get; set; } = new object();
    }
}
