class StuClass {
  int? id;
  String? name;
  String? clgname;
  String? branch;
  int? year;
    
  StuClass({ 
    this.id, 
    this.name, 
    this.clgname, 
    this.branch, 
    this.year}
  );
 
  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'name': name, 
      'clgname': clgname, 
      'branch': branch, 
      'year': year
    };
  }

  StuClass.fromMap(Map<String, dynamic> stuClass){
    id = stuClass['id'];
    name = stuClass['name'];
    clgname = stuClass['clgname'];
    branch = stuClass['branch'];
    year = stuClass['year'];
  }

}