
// import React, { useState } from 'react';
// import UserList from './UserList';
// import UserForm from './UserForm';
// import UserDetail from './UserDetail';

// const App = () => {
//   const [selectedUserId, setSelectedUserId] = useState(null);
//   const [refreshFlag, setRefreshFlag] = useState(false);

//   const handleUserCreated = () => setRefreshFlag(prev => !prev);

//   return (
//     <div style={{ padding: '20px' }}>
//       <h1>Expense Dashboard</h1>
//       <UserForm onUserCreated={handleUserCreated} />
//       <UserList onSelectUser={setSelectedUserId} key={refreshFlag} />
//       {selectedUserId && <UserDetail userId={selectedUserId} />}
//     </div>
//   );
// };

// export default App;


import React from 'react';
import Dashboard from './Dashboard';

function App() {
  return (
    <div className="App">
      <Dashboard />
    </div>
  );
}

export default App;
