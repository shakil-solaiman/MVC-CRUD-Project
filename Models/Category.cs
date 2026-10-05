namespace CRUD_Operation.Models
{
    public class Category
    {
        public int Id {get; set;}
        public string name {get; set;} = string.Empty;
        public string? description {get; set;}
        public bool isActive {get; set;} = true;
        public DateTime createdTime { get; set; } = DateTime.Now;

    }
}