# 객체 생성과 파괴

## 아이템 1. 생성자 대신 정적 팩터리 메서드를 고려하라

- 장점
  - 이름을 가질 수 있다.
    - 예) `BigInteger.probablePrime()`
    - 반환될 객체의 특성을 쉽게 묘사할 수 있다.
    - 시그니처(signature)가 같은 생성자가 여러 개 필요할 때 고려하라.
  - 호출될 때마다 인스턴스를 새로 생성하지 않아도 된다.
    - 예) `Boolean.valueOf()`, `Integer.valueOf()`
    - 불변 클래스(immutable class)에서 유용하다.
    - 불필요한 객체 생성을 피할 수 있다.
    - 메모리 절약, 성능 향상시킬 수 있다.
    - GoF: Flyweight 패턴
  - 반환 타입의 하위 타입 객체를 반환할 수 있다.
    - API 설계자가 반환할 객체의 클래스를 자유롭게 선택할 수 있는 유연성을 제공한다.
    - API 사용자에게 구현 클래스의 노출을 피할 수 있다.
    - API의 외견을 단순하게 유지할 수 있다.
    - 프로그래머가 API를 사용하기 위해 익혀야 하는 개념의 수와 난이도를 낮춘다.
  - 입력 매개변수에 따라 매번 다른 클래스의 객체를 반환할 수 있다.
    - 예) `EnumSet`의 `noneOf()` 리턴 객체: `RegularEnumSet`, `JumboEnumSet` 
    - 매개변수에 따라 적절한 클래스의 객체를 반환한다.
    - API 클라이언트 입장에서는 반환된 객체의 클래스가 무엇인지 알 필요가 없다.
  - 정적 팩터리 메서드를 작성하는 시점에는 반환할 객체의 클래스가 존재하지 않아도 된다.
    - 예) JDBC API의 `DriverManager.getConnection()`
    - 서비스 제공자 프레임워크를 만들 때 유용하다.
    - 서비스 제공자는 서비스 구현체다. 예) MySQL JDBC 드라이버, Oracle JDBC 드라이버
    - 서비스 제공자 프레임워크의 핵심 컴포넌트
        - 서비스 인터페이스: 구현체의 동작을 정의. 예) `Connection`
        - 제공자 등록 API: 제공자가 구현체를 등록할 때 사용. 예) `DriverManager.registerDriver()`
        - **서비스 접근 API**: 클라이언트가 서비스의 인스턴스를 얻을 때 사용. **유연한 정적 팩토리** 메서드. 예) `DriverManager.getConnection()`
        - 서비스 제공자 인터페이스: 서비스 인터페이스의 인스턴스를 생성하는 팩토리 객체. 예) `Driver`
    - 서비스 제공자 프레임워크의 예
        - JDBC API
        - JNDI API
        - Java Cryptography Architecture(JCA)
        - Java Authentication and Authorization Service(JAAS)
        - Java Image I/O API
        - Java Sound API
        - Java XML API
    - 범용 서비스 제공자 프레임워크
        - `java.util.ServiceLoader` 클래스
        - 서비스 제공자 프레임워크를 쉽게 만들고 사용할 수 있게 해준다.
- 단점
    - 상속을 하려면 public이나 protected 생성자가 필요하다. 정적 팩터리 메서드만 제공하는 클래스는 확장할 수 없다.
    - 정적 팩터리 메서드는 프로그래머가 찾기 어렵다.
        - API 문서에서 정적 팩터리 메서드를 잘 찾아봐야 한다.
        - 메서드 이름도 널리 알려진 규약을 따라 짓는 것이 좋다.
        - 예) `from`, `valueOf`, `of`, `instance` | `getInstance`, `create` | `newInstance`, `getType`, `newType`,  `type` 등의 이름을 사용한다.

## 아이템 2. 생성자에 매개변수가 많다면 빌더를 고려하라
## 아이템 3. private 생성자나 열거 타입으로 싱글턴임을 보증하라
## 아이템 4. 인스턴스화를 막으려면 private 생성자를 사용하라
## 아이템 5. 자원을 직접 명시하지 말고 의존 객체 주입을 사용하라
## 아이템 6. 불필요한 객체 생성을 피하라
## 아이템 7. 다 쓴 객체 참조를 해제하라
## 아이템 8. finalizer와 cleaner는 신중히 사용하라
## 아이템 9. try-finally보다는 try-with-resources를 사용하라
