using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataImport.Domain
{
    public class EntityInfo
    {
        public int ID { get; set; }
    }

    public class KeyValueInfo
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }
}
