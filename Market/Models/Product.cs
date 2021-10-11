namespace Market.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; } //название
        public decimal Price { get; set; } //цена
        public int NumberOfProducts { get; set; } //количество продуктов
        public string Country{ get; set; } //страна-производитель
        public string NextArrivalDate { get; set; } //дата следующего поступления
    }
}