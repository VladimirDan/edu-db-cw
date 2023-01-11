const express = require('express');
const db = require('./database');

const app = express();
const PORT = 3000;
app.use(express.json());

app.get('/all', (req, res) => {
    const command = 'SELECT * FROM branch;';

    db.query(command, (error, result) => {
      if (error) return res.status(500).json(err);
      res.status(200).json(result);
    });
  });

app.get('/get', (req, res) => {
    const command = `SELECT * FROM branch WHERE branch_id = ${req.query.id}`;
    console.log(command);
    db.query(command, (error, result) => {
      if (error) return res.status(500).json(error);
      if (result.length == 0) return res.status(404).json({ 'message': 'No branch with a given branch id'});
      res.status(200).json(result[0]);
    });
  });

app.post('/new', (req, res) => {
    const branch_id = req.query.id;
    const editor_id = req.query.editor_id;
    const NER = req.query.NER;
    const SEMANTIC = req.query.SEMANTIC;
    const INTENTION = req.query.INTENTION;

    if(!branch_id || !editor_id || !NER || !SEMANTIC || !INTENTION){
        return res.status(400).json({'error': 'Data is not match the table'});
    }
    
    const command = `INSERT INTO branch VALUES (${branch_id}, ${editor_id}, ${NER}, ${SEMANTIC}, ${INTENTION})`;
    console.log(command);
    db.query(command, (error, result) => {
		if (error) return res.status(500).json(error);
		res.status(200).json({'show': 'Successfully added new branch'});
	});
  });

 app.put('/upd', (req, res) => {
    const values = {
		editor_id: 'editor_id',
		NER: 'NER',
		SEMANTIC: 'SEMANTIC',
        INTENTION: 'INTENTION'
	};

	for (const arg in values) {
		if (req.query[arg]) {
			const command = `UPDATE branch SET ${values[arg]} = ${req.query[arg]} WHERE branch_id = ${req.query.id}`;

			db.query(command, (error, result) => {
				if (error) return res.status(500).json(error);
				res.status(200).json({'show': 'Updated row'});
			});
		}
	}
  });

  app.delete('/del', (req, res) => {
	const command = `DELETE FROM branch WHERE branch_id = ${req.query.id}`;

	db.query(command, (error, result) => {
		if (error) return res.status(500).json(error);
		res.status(200).json({'show': 'Row was successfully deleted'});
	});
  });
  
  
  
  
  

  
db.connect(app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  }));
