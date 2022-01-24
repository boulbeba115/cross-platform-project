using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Domain
{
    public interface IDataRepository<IEntity>
    {
        IList<IEntity> GetAll();
        IEntity Get(long id);
        IEntity Add(IEntity entity);
        void Edit(IEntity entity);
        void Delete(long id);
    }
}
