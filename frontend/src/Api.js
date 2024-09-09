import React, { useState, useEffect } from 'react';
import axios from 'axios';

function Api() {
  const [data, setData] = useState(null);

  useEffect(() => {
    axios.get('https://api.project_devops.com/data')
      .then(response => {
        setData(response.data);
      })
      .catch(error => {
        console.error(error);
      });
  }, []);

  return (
    <div>
      {data ? (
        <ul>
          {data.map(item => (
            <li key={item.id}>{item.name}</li>
          ))}
        </ul>
      ) : (
        <p>Cargando...</p>
      )}
    </div>
  );
}

export default Api;
