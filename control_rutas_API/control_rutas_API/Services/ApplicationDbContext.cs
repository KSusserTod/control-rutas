using control_rutas_API.Models;
using Microsoft.EntityFrameworkCore;

namespace control_rutas_API.Services
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<Employee> employees { get; set; } = null!;
        public DbSet<Routes> routes { get; set; } = null!;
        public DbSet<Ciudad> ciudad { get; set; } = null!;
        public DbSet<Estado> estado { get; set; } = null!;
    }
}
