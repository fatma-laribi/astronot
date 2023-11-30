import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';

import { App } from './app';

describe('AppComponent', () => {
  let component: App;
  let fixture: ComponentFixture<App>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [App],
      imports: [RouterTestingModule], // Use RouterTestingModule for testing navigation links
    });

    fixture = TestBed.createComponent(App);
    component = fixture.componentInstance;
  });

  it('should create the app', () => {
    expect(component).toBeTruthy();
  });

  it(`should have as title 'Astronot 👩‍🚀 Angular'`, () => {
    expect(component.title).toEqual('Astronot 👩‍🚀 Angular');
  });

  it('should render title in a h1 tag', () => {
    fixture.detectChanges();
    const compiled = fixture.nativeElement;
    expect(compiled.querySelector('h1').textContent).toContain('Astronot 👩‍🚀 Angular');
  });

  // Add more tests for other properties and behavior as needed
});
