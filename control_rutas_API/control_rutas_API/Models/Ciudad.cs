using Microsoft.AspNetCore.DataProtection.KeyManagement;

namespace control_rutas_API.Models
{
    public class Ciudad
    {
        public int Id { get; set; }
        public int IdEstado { get; set; }
        public string Nombre { get; set; } = "";
        public bool Estatus {  get; set; }
    }
}
