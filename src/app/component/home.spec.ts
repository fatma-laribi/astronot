import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { of } from 'rxjs';

import { Home } from './home';
import { BlogService } from '../services/blog.service';

describe('Home', () => {
  let component: Home;
  let fixture: ComponentFixture<Home>;
  let blogService: BlogService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [Home],
      imports: [HttpClientTestingModule],
      providers: [BlogService],
    });

    fixture = TestBed.createComponent(Home);
    component = fixture.componentInstance;
    blogService = TestBed.inject(BlogService);
  });

  it('should set blogs property when ngOnInit is called', fakeAsync(() => {
    const mockBlogs = [
      { id: 1, name: 'Blog 1', description: 'Description 1', cover: 'cover1.jpg', content: 'Content 1' },
      { id: 2, name: 'Blog 2', description: 'Description 2', cover: 'cover2.jpg', content: 'Content 2' },
      { id: 3, name: 'Blog 3', description: 'Description 3', cover: 'cover3.jpg', content: 'Content 3' },
    ];

    // Create a spy on http.get and return an observable that simulates a successful response
    spyOn(blogService, 'getBlogs').and.returnValue(of(mockBlogs));

    // Trigger the ngOnInit or any method that calls getBlogs
    component.ngOnInit(); // Assuming ngOnInit calls getBlogs

    // Advance the fakeAsync timer
    tick();

    // Trigger change detection
    fixture.detectChanges();

    // Now you can assert the component's behavior based on the successful response
    expect(component.blogs).toEqual(mockBlogs);
  }));
});
