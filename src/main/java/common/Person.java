package common;

public class Person {
	// 자바빈즈 규약
	// 1. 기본패키지 이외의 패키지에 속해야한다. -> package common;
	// 2. 멤버변수 private 선언
	// 3. 기본 생성자 (자동생성) 
	// 4. 멤버변수에 접근가능한 getter/setter 메서드생성 
	// 5. getter/setter 는 접근지정자로 public 으로 선언
	
	// 필드 (멤버변수)
	private String name;
	private int age;
	
	public Person() {} // 기본생성자
	
	// 커스텀생성자
	public Person(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}

	public String getName() { return name; }

	public void setName(String name) { this.name = name; }

	public int getAge() { return age; }

	public void setAge(int age) { this.age = age; }
	
	

}
