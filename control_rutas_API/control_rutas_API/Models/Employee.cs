namespace control_rutas_API.Models
{
    public class Employee
    {
        public int Id { get; set; } 
        public int IdCiudad { get; set; }
        public string Nombre { get; set; } = "";
        public string ApellidoPaterno { get; set; } = "";
        public string ApellidoMaterno { get; set; } = "";  
        public DateTime FechaNacimiento { get; set; }
        public float Sueldo { get; set; }
        public bool Status { get; set; }
        public DateTime FechaCreacion { get; set; } = DateTime.Now;
        public DateTime? FechaModificacion { get; set; }
        public DateTime? FechaCancelacion { get; set; }
    }
}
