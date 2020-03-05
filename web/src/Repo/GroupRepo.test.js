import GroupRepo from './GroupRepo'
import * as browserWrapper from './browserWrapper'

describe('GroupRepo', () => {
  let fetchWrapperSpy
  beforeEach(() => {
    fetchWrapperSpy = jest.spyOn(browserWrapper, 'fetchWrapper')
  })
  afterEach(() => {
    fetchWrapperSpy.mockClear()
  })

  describe('getList', () => {
    it('makes correct request', () => {
      const repo = new GroupRepo()

      repo.getList()

      expect(fetchWrapperSpy.mock.calls.length).toBe(1)
      const expectedUrl = 'http://localhost:4000/api/groups'
      expect(fetchWrapperSpy.mock.calls[0][0]).toEqual(expectedUrl)
      const expectedOptions = {headers: {'Accept': 'application/json', 'Origin': 'http://localhost:3000'}}
      expect(fetchWrapperSpy.mock.calls[0][1]).toEqual(expectedOptions)
    })
  })

  describe('getDetails', () => {
    it('makes correct request', () => {
      const repo = new GroupRepo()

      repo.getDetails('groupId')

      expect(fetchWrapperSpy.mock.calls.length).toBe(1)
      const expectedUrl = 'http://localhost:4000/api/groups/groupId'
      expect(fetchWrapperSpy.mock.calls[0][0]).toEqual(expectedUrl)
      const expectedOptions = {headers: {'Accept': 'application/json', 'Origin': 'http://localhost:3000'}}
      expect(fetchWrapperSpy.mock.calls[0][1]).toEqual(expectedOptions)
    })
  })
})
