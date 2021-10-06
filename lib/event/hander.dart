typedef Type Result(params);

abstract class Handler<T> {
  Result handle(T msg);
}
