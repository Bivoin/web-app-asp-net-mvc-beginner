using System.Data.Entity;

namespace Market.Models
{
    public class MarketContext : DbContext
    {
        public DbSet<Product> Products { get; set; }
        public MarketContext() : base("MarketEntity")
        { }
    }
}