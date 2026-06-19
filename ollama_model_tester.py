#!/usr/bin/env python3
"""
Ollama Model Testing Framework
Tests models progressively from smallest to largest with comprehensive benchmarking
"""

import requests
import json
import time
from datetime import datetime
from typing import Dict, List, Any
import statistics

class OllamaModelTester:
    def __init__(self, base_url: str = "http://localhost:11434"):
        self.base_url = base_url
        self.results = []
        self.test_suite = self._create_test_suite()
    
    def _create_test_suite(self) -> List[Dict[str, Any]]:
        """Create a comprehensive test suite with detailed instructions"""
        return [
            {
                "name": "Code Generation - Simple Function",
                "prompt": """Write a Python function that takes a list of numbers and returns the sum.
Requirements:
- Function should handle empty lists
- Include error handling
- Add docstring
- Keep it simple and readable""",
                "category": "code_generation",
                "weight": 1.0
            },
            {
                "name": "Bug Fix Task",
                "prompt": """Here's buggy code:
```python
def find_max(numbers):
    max_val = 0
    for num in numbers:
        if num > max_val
            max_val = num
    return max_val
```

Tasks:
1. Identify the bug
2. Explain why it's wrong
3. Provide the corrected code
4. Explain the fix""",
                "category": "bug_fixing",
                "weight": 1.0
            },
            {
                "name": "Code Explanation",
                "prompt": """Explain what this code does:
```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

Please:
- Explain the logic step-by-step
- Identify any performance issues
- Suggest improvements
- Rate the code quality (1-10)""",
                "category": "explanation",
                "weight": 0.8
            },
            {
                "name": "Function Optimization",
                "prompt": """Optimize this function:
```python
def is_prime(n):
    if n < 2:
        return False
    for i in range(2, n):
        if n % i == 0:
            return False
    return True
```

Requirements:
- Identify inefficiencies
- Provide optimized version
- Explain performance improvement
- Test with examples (2, 17, 100)""",
                "category": "optimization",
                "weight": 1.0
            },
            {
                "name": "Algorithm Understanding",
                "prompt": """Explain the following algorithm:
```python
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1
```

Include:
- Time and space complexity
- When to use this vs linear search
- Example walkthrough""",
                "category": "algorithm",
                "weight": 0.9
            },
            {
                "name": "Code Review Task",
                "prompt": """Review this code and provide feedback:
```python
def process_data(data):
    result = []
    for item in data:
        if item != None and item != "":
            result.append(item.strip().upper())
    return result
```

Comment on:
- Readability
- Performance
- Best practices
- Suggestions for improvement""",
                "category": "code_review",
                "weight": 0.8
            }
        ]
    
    def test_model(self, model_name: str) -> Dict[str, Any]:
        """Test a specific model with the entire test suite"""
        print(f"\n{'='*80}")
        print(f"Testing Model: {model_name}")
        print(f"Start Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"{'='*80}\n")
        
        model_results = {
            "model": model_name,
            "timestamp": datetime.now().isoformat(),
            "tests": [],
            "summary": {}
        }
        
        total_time = 0
        response_times = []
        
        for i, test in enumerate(self.test_suite, 1):
            print(f"[{i}/{len(self.test_suite)}] Running: {test['name']}")
            print(f"Category: {test['category']}")
            print("-" * 80)
            
            try:
                start_time = time.time()
                response = self._query_model(model_name, test['prompt'])
                end_time = time.time()
                
                response_time = end_time - start_time
                response_times.append(response_time)
                total_time += response_time
                
                test_result = {
                    "test_name": test['name'],
                    "category": test['category'],
                    "prompt": test['prompt'],
                    "response": response,
                    "response_time": response_time,
                    "weight": test['weight'],
                    "status": "success"
                }
                
                model_results["tests"].append(test_result)
                
                # Display response snippet
                response_preview = response[:200] + "..." if len(response) > 200 else response
                print(f"Response (first 200 chars): {response_preview}")
                print(f"Response Time: {response_time:.2f}s")
                print()
                
            except Exception as e:
                print(f"❌ Error testing {test['name']}: {str(e)}")
                model_results["tests"].append({
                    "test_name": test['name'],
                    "category": test['category'],
                    "status": "error",
                    "error": str(e)
                })
                print()
        
        # Calculate summary statistics
        model_results["summary"] = {
            "total_tests": len(self.test_suite),
            "successful_tests": sum(1 for t in model_results["tests"] if t.get("status") == "success"),
            "failed_tests": sum(1 for t in model_results["tests"] if t.get("status") == "error"),
            "total_time": total_time,
            "average_response_time": statistics.mean(response_times) if response_times else 0,
            "min_response_time": min(response_times) if response_times else 0,
            "max_response_time": max(response_times) if response_times else 0,
            "median_response_time": statistics.median(response_times) if response_times else 0
        }
        
        self.results.append(model_results)
        return model_results
    
    def _query_model(self, model_name: str, prompt: str, timeout: int = 300) -> str:
        """Send a query to the Ollama model"""
        url = f"{self.base_url}/api/generate"
        
        payload = {
            "model": model_name,
            "prompt": prompt,
            "stream": False,
            "temperature": 0.7
        }
        
        response = requests.post(url, json=payload, timeout=timeout)
        response.raise_for_status()
        
        result = response.json()
        return result.get("response", "")
    
    def print_summary(self):
        """Print a comprehensive summary of all test results"""
        if not self.results:
            print("No test results to display")
            return
        
        print(f"\n{'='*80}")
        print("TESTING SUMMARY - ALL MODELS")
        print(f"{'='*80}\n")
        
        for result in self.results:
            print(f"Model: {result['model']}")
            print(f"Timestamp: {result['timestamp']}")
            summary = result['summary']
            print(f"  Tests Passed: {summary['successful_tests']}/{summary['total_tests']}")
            print(f"  Total Time: {summary['total_time']:.2f}s")
            print(f"  Avg Response Time: {summary['average_response_time']:.2f}s")
            print(f"  Min Response Time: {summary['min_response_time']:.2f}s")
            print(f"  Max Response Time: {summary['max_response_time']:.2f}s")
            print(f"  Median Response Time: {summary['median_response_time']:.2f}s")
            print()
        
        # Comparison
        print(f"\n{'='*80}")
        print("MODEL COMPARISON")
        print(f"{'='*80}\n")
        
        for result in self.results:
            model = result['model']
            summary = result['summary']
            success_rate = (summary['successful_tests'] / summary['total_tests'] * 100) if summary['total_tests'] > 0 else 0
            print(f"{model:30} | Success Rate: {success_rate:6.1f}% | Avg Time: {summary['average_response_time']:6.2f}s")
    
    def save_results(self, filename: str = "ollama_test_results.json"):
        """Save detailed results to a JSON file"""
        with open(filename, 'w') as f:
            json.dump(self.results, f, indent=2)
        print(f"\nResults saved to {filename}")


def main():
    """Main testing function"""
    tester = OllamaModelTester()
    
    # Models to test (from smallest to largest)
    models_to_test = [
        "deepseek-coder:1.3b",      # 1.3B parameters
        "qwen2.5-coder:3b",          # 3B parameters
        "novaforgeai/starcoder2:3b-optimized",  # 3B parameters
        "phi4-mini:latest",          # Small phi model
        "qwen2.5-coder:7b",          # 7B parameters
        "qwen2.5-coder:14b",         # 14B parameters
    ]
    
    print("\n" + "="*80)
    print("OLLAMA MODEL TESTING FRAMEWORK")
    print("Progressive Testing from Smallest to Largest Models")
    print("="*80)
    
    for model in models_to_test:
        try:
            model_result = tester.test_model(model)
            print(f"\n✅ Completed testing: {model}")
            print(f"Success Rate: {model_result['summary']['successful_tests']}/{model_result['summary']['total_tests']}")
        except Exception as e:
            print(f"\n❌ Failed to test {model}: {str(e)}")
    
    # Print summary and save results
    tester.print_summary()
    tester.save_results()


if __name__ == "__main__":
    main()
