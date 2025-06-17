namespace control_rutas_API.Models
{
    public class Routes
    {
        public int Id { get; set; } 
        public int IdCiudad { get; set; }
        public int IdChofer { get; set; }
        public string Nombre { get; set; } = "";
        public string TipoServicio { get; set; } = "";
        public int Capacidad { get; set; }
        public bool Estatus { get; set; }
        public DateTime FechaCreacion { get; set; } = DateTime.Now;
        public DateTime? FechaModificacion { get; set; }
        public DateTime? FechaCancelacion { get; set; }
    }
}
