// Tests handling of inheritance when a base class isn't provided to SWIG
%module inherit_missing

%{
/* Define the class internally, but don't tell SWIG about it */
class Foo {
public:
     virtual char *blah() {
	return (char *) "Foo::blah";
     }
};
%}

/* Forward declaration.  Says that Foo is a class, but doesn't provide a definition */

class Foo;

%warnfilter(402) Bar; /* Base class is incomplete */
%warnfilter(402) Spam; /* Base class is incomplete */

%inline %{

class Bar : public Foo {
 public:
  virtual char *blah() {
    return (char *) "Bar::blah";
  };
};

class Spam : public Bar {
  public:
  virtual char *blah() {
    return (char *) "Spam::blah";
  };
};

Foo *new_Foo() {
   return new Foo();
}

char *do_blah(Foo *f) {
  return f->blah();
}
%}
