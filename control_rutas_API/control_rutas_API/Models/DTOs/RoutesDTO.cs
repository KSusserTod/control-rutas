namespace control_rutas_API.Models.DTOs
{
    public class RoutesDTO
    {
        public int IdCiudad { get; set; }
        public int IdChofer { get; set; }
        public string Nombre { get; set; } = "";
        public string TipoServicio { get; set; } = "";
        public int Capacidad { get; set; }
        public bool Estatus { get; set; }
    }
}
